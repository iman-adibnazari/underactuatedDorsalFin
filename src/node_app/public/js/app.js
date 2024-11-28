document.addEventListener('DOMContentLoaded', function() {
    const buttonMap = {
        'ArrowUp': 'FORWARD',
        'ArrowDown': 'BACKWARD',
        'ArrowLeft': 'LEFT',
        'ArrowRight': 'RIGHT',
        ' ': 'STOP'
    };
  
    document.addEventListener('keydown', function(event) {
        const command = buttonMap[event.key];
        if (command) {
            sendCommand(command);
        }
    });
  
    document.getElementById('forward').addEventListener('click', () => sendCommand('FORWARD'));
    document.getElementById('backward').addEventListener('click', () => sendCommand('BACKWARD'));
    document.getElementById('left').addEventListener('click', () => sendCommand('LEFT'));
    document.getElementById('right').addEventListener('click', () => sendCommand('RIGHT'));
    document.getElementById('stop').addEventListener('click', () => sendCommand('STOP'));
  });
  
  function sendCommand(direction) {
    fetch(`/command/${direction}`, { method: 'POST' })
        .then(response => response.text())
        .then(data => console.log(data))
        .catch(error => console.error('Error:', error));
  }