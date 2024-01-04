from __future__ import print_function
import sys
import cv2
from random import randint
import numpy as np
from scipy.io import savemat
import serial
import time

arduino = serial.Serial(port='COM10',   baudrate=115200, timeout=.1)


def write_read(x):
    arduino.write(bytes(x,   'utf-8'))
    data = arduino.readline()
    # time.sleep(0.05)
    # data = arduino.readline()
    # return data
    return data

import numpy as np
import cv2 as cv

cap = cv.VideoCapture(0)
if not cap.isOpened():
    print("Cannot open camera")
    exit()

# Read in first frame
ret, frame = cap.read()
# Select object to track
roi = cv.selectROI("tracker", frame)

# Create Tracker object
tracker = cv.TrackerCSRT_create()

# Initialize tracker
tracker.init(frame, roi)


while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    # Update the tracker
    success, roi = tracker.update(frame)
    # Draw the bounding box on the frame
    cv2.rectangle(frame, (int(roi[0]), int(roi[1])), (int(roi[0] + roi[2]), int(roi[1] + roi[3])), (0, 255, 0), 2)
    # Get coordinates of roi center
    roiCenter = (int(roi[0] + roi[2]/2), int(roi[1] + roi[3]/2))
    # Display y coordinate of center in top right corner
    cv2.putText(frame, str(roiCenter[1]), (frame.shape[1]-100, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2, cv2.LINE_AA)
    # Draw the center of the roi
    cv2.circle(frame, roiCenter, 5, (0, 0, 255), -1)

    # Send y coordinate to arduino
    value = write_read(str(int(roiCenter[1])))
    print(value)

    # Our operations on the frame come here
    # gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    # Display the frame
    cv2.imshow("tracker", frame)
    
    if cv.waitKey(1) == ord('q'):
        break
# When everything done, release the capture
cap.release()
cv.destroyAllWindows()
