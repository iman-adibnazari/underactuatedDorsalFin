const express = require('express');
const mqtt = require('mqtt');
const path = require('path');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 3000;
const mqttHost = process.env.MQTT_HOST || 'localhost';
const pool = new Pool({
  connectionString: process.env.DB_URL
});

// MQTT Client Setup
const client = mqtt.connect(`mqtt://${mqttHost}:1883`);

client.on('connect', () => {
  console.log('Connected to MQTT Broker at ' + mqttHost);
});

// Middleware
app.use(express.static('public'));
app.use(express.json()); // For parsing JSON bodies

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'index.html'));
});

// Handle start command with delay
app.post('/start', (req, res) => {
  const delay = req.body.delay || 0;
  const now = new Date();

  try {
    // Publish to MQTT topic with delay
    const message = delay.toString()+",";
    client.publish('robot/start', message);
    res.send(`Start command with ${delay}s delay sent to MQTT broker at ${now}`);
  } catch (err) {
    console.error('Error publishing start command:', err);
    if (!res.headersSent) {
      res.status(500).send('Failed to send start command');
    }
  }
});

// Handle stop command with delay
app.post('/stop', (req, res) => {
  const delay = req.body.delay || 0;
  const now = new Date();

  try {
    // Publish to MQTT topic with delay
    const message = delay.toString()+",";
    client.publish('robot/stop', message);
    res.send(`Stop command with ${delay}s delay sent to MQTT broker at ${now}`);
  } catch (err) {
    console.error('Error publishing stop command:', err);
    if (!res.headersSent) {
      res.status(500).send('Failed to send stop command');
    }
  }
});

// Handle gait parameters
app.post('/send-parameters', (req, res) => {
  const { A_f, f, b_f, A_b, b_b, phi } = req.body;
  const now = new Date();

  try {
    // Create tuple of parameters
    const paramTuple = [A_f, f, b_f, A_b, b_b, phi].map(Number);
    
    // Check if all parameters are valid numbers
    if (paramTuple.some(isNaN)) {
      throw new Error('Invalid parameter values');
    }

    // Convert tuple to string format
    const paramString = paramTuple.join(',')+","; // Add a comma at the end so that strtok function on arduino knows where last value ends
    
    // Publish to MQTT topic
    client.publish('robot/gait', paramString);
    res.send(`Gait parameters sent to MQTT broker at ${now}`);
  } catch (err) {
    console.error('Error publishing gait parameters:', err);
    if (!res.headersSent) {
      res.status(500).send('Failed to send gait parameters');
    }
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});