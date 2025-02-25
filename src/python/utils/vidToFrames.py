import cv2
import os
import numpy as np

# Video filepath
video_path = './data/raw/CameraCalibration/vids/CamCalibrationVid.mp4'
output_folder = './data/raw/CameraCalibration/imgs'

# Create output folder if it doesn't exist
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Open video file
cap = cv2.VideoCapture(video_path)

# Check if video opened successfully
if not cap.isOpened():
    print("Error: Could not open video.")
    exit()

# Read video frame by frame
frame_count = 0
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    # Save frame to output folder
    frame_path = os.path.join(output_folder, f'CalibFrame_{frame_count}.jpg')
    cv2.imwrite(frame_path, frame)
    frame_count += 1

    # Display frame
    cv2.imshow('Frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release video capture and close windows
cap.release()
cv2.destroyAllWindows()
