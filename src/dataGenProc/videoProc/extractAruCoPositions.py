import cv2
import numpy as np
import matplotlib.pyplot as plt
import os
import sys

# ARUCO PARAMETERS HERE:
ARUCO_DICT = cv2.aruco.DICT_4X4_250
SQUARES_VERTICALLY = 5
SQUARES_HORIZONTALLY = 5
SQUARE_LENGTH = 0.04
MARKER_LENGTH = 0.03


# Path to the video file
video_path = "./data/raw/videos/fishV3/Experiments/ForwardPretest_0p125_8_0_0_0_0-TopView-Trial2.mp4"

# Path to the output file
output_path = "./data/processed/aruco_positions/ForwardPretest_0p125_8_0_0_0_0-TopView-Trial2.txt"

#  aruco dictionary
dictionary = cv2.aruco.getPredefinedDictionary(ARUCO_DICT)

# aruco parameters
params = cv2.aruco.DetectorParameters()

# Read the video file
cap = cv2.VideoCapture(video_path)

# Check if the video file is opened
if not cap.isOpened():
    print("Error: Could not open the video file")
    sys.exit()

# Get the video frame width and height
frame_width = int(cap.get(3))
frame_height = int(cap.get(4))

# Create a video writer object
out = cv2.VideoWriter('output.avi', cv2.VideoWriter_fourcc('M', 'J', 'P', 'G'), 10, (frame_width, frame_height))

# Create a list to store the aruco positions
aruco_positions = []

# Loop through the video frames
while True:
    # Read the video frame
    ret, frame = cap.read()

    # Check if the video frame is read
    if not ret:
        break

    # Detect the aruco markers in the video frame
    corners, ids, rejectedImgPoints = cv2.aruco.detectMarkers(frame, dictionary, parameters=params)

    # Check if the aruco markers are detected
    if ids is not None:
        # Draw the detected aruco markers
        cv2.aruco.drawDetectedMarkers(frame, corners, ids)

        # Loop through the detected aruco markers
        for i in range(len(ids)):
            # Get the aruco marker id
            id = ids[i][0]

            # Get the aruco marker corners
            corner = corners[i][0]

            # Calculate the aruco marker position
            x = (corner[0][0] + corner[2][0]) / 2
            y = (corner[0][1] + corner[2][1]) / 2

            # Append the aruco marker position to the list
            aruco_positions.append((id, x, y))

    # Write the video frame
    out.write(frame)

# Release the video file
cap.release()

# Release the video writer
out.release()

# Close the video writer
cv2.destroyAllWindows()

# Save the aruco positions to the output file
with open(output_path, 'w') as f:
    for id, x, y in aruco_positions:
        f.write(f'{id} {x} {y}\n')

# Print the number of aruco markers detected
print(f'Number of aruco markers detected: {len(aruco_positions)}')


# Plot the aruco positions
ids, xs, ys = zip(*aruco_positions)
plt.scatter(xs, ys)
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Aruco Marker Positions')
plt.show()




