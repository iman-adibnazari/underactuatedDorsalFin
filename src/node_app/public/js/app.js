// DOM Elements
const parameterSets = document.getElementById('parameter-sets');
const template = document.getElementById('parameter-set-template');
const timeCounter = document.getElementById('time-counter');

// Initialize parameter sets
function initializeParameterSets(numSets = 3) {
    for (let i = 0; i < numSets; i++) {
        const clone = template.content.cloneNode(true);
        const parameterSet = clone.querySelector('.parameter-set');
        parameterSet.id = `parameter-set-${i + 1}`;
        
        // Add send button handler
        const sendButton = clone.querySelector('.send-button');
        sendButton.addEventListener('click', () => handleSend(i + 1));
        
        parameterSets.appendChild(clone);
    }
}

// Handle sending parameters to the server
async function handleSend(setId) {
    const parameterSet = document.getElementById(`parameter-set-${setId}`);
    const inputs = parameterSet.querySelectorAll('input[data-param]');
    const parameters = {};

    inputs.forEach(input => {
        parameters[input.dataset.param] = parseFloat(input.value) || 0;
    });

    try {
        const response = await fetch('/send-parameters', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(parameters)
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        console.log(`Parameters for set ${setId} sent successfully:`, parameters);
    } catch (error) {
        console.error('Error sending parameters:', error);
    }
}

// Update sensor readings
function updateSensorReadings(data) {
    document.getElementById('left-temp').textContent = `${data.leftHead.temp}°C`;
    document.getElementById('left-humidity').textContent = `${data.leftHead.humidity}%`;
    document.getElementById('right-temp').textContent = `${data.rightHead.temp}°C`;
    document.getElementById('right-humidity').textContent = `${data.rightHead.humidity}%`;
}

// Update time counter
function updateTimeCounter(time) {
    timeCounter.textContent = time;
}

// WebSocket connection for real-time updates
let ws;
function initializeWebSocket() {
    ws = new WebSocket(`ws://${window.location.host}`);
    
    ws.onmessage = (event) => {
        const data = JSON.parse(event.data);
        
        if (data.type === 'sensor-data') {
            updateSensorReadings(data.payload);
        } else if (data.type === 'time-counter') {
            updateTimeCounter(data.payload);
        }
    };

    ws.onclose = () => {
        console.log('WebSocket connection closed. Attempting to reconnect...');
        setTimeout(initializeWebSocket, 1000);
    };
}

// Handle start/stop commands
async function sendCommand(command) {
    const delayTime = parseInt(document.getElementById(`${command}-delay-time`).value) || 0;
    
    try {
        const response = await fetch(`/${command}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ delay: delayTime })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        console.log(`${command} command sent successfully with ${delayTime}s delay`);
    } catch (error) {
        console.error(`Error sending ${command} command:`, error);
    }
}

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    initializeParameterSets();
    
    // Add start and stop button event listeners
    const startButton = document.getElementById('start-button');
    const stopButton = document.getElementById('stop-button');
    
    startButton.addEventListener('click', () => sendCommand('start'));
    stopButton.addEventListener('click', () => sendCommand('stop'));
    
    // Add input validation for delay times
    ['start', 'stop'].forEach(command => {
        const delayInput = document.getElementById(`${command}-delay-time`);
        delayInput.addEventListener('input', (e) => {
            const value = parseInt(e.target.value);
            if (value < 0) {
                e.target.value = 0;
            }
        });
    });
});