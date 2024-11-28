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

// Middleware to serve static files
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'index.html'));
});

// API to handle direction commands
app.post('/command/:direction', async (req, res) => {
  const { direction } = req.params;
  const now = new Date();
  let leftSpeed = 0;
  let rightSpeed = 0;
  let speedsEncoded = 0;

  switch (direction) { // Set motor speeds based on direction
    case 'FORWARD':
      leftSpeed = 70;
      rightSpeed = 70;
      break;
    case 'BACKWARD':
      leftSpeed = -70;
      rightSpeed = -70;
      break;
    case 'LEFT':
      leftSpeed = -70;
      rightSpeed = 70;
      break;
    case 'RIGHT':
      leftSpeed = 70;
      rightSpeed = -70;
      break;
    case 'STOP':
      leftSpeed = 0;
      rightSpeed = 0;
      break;
  }

  // Encode speeds into single 32-bit integer
  speedsEncoded += Math.abs(Math.floor(rightSpeed));
  speedsEncoded += (rightSpeed < 0 ? 1000 : 0);
  speedsEncoded += Math.abs(Math.floor(leftSpeed) * 10000);
  speedsEncoded += (leftSpeed < 0 ? 10000000 : 0);

  try {
    // await pool.query('INSERT INTO commands (direction, time_sent, left_speed, right_speed, encoded_speed, source, username) VALUES ($1, $2, $3, $4, $5, $6, $7)', [direction, now.toISOString(), leftSpeed, rightSpeed, speedsEncoded, 'webUI', 'web_user']);
    // Publish MQTT messages
    client.publish('motorSpeed/left', leftSpeed.toString());
    client.publish('motorSpeed/right', rightSpeed.toString());
    client.publish('motorSpeed/encoded', speedsEncoded.toString());
    client.publish('robot/control', direction);
    res.send(`Command ${direction} sent to MQTT broker at ${now}`);
  } catch (err) {
    console.error('Database error:', err);
    if (!res.headersSent) {
      res.status(500).send('Failed to record command');
    }
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});