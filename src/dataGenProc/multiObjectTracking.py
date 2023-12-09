from __future__ import print_function
import sys
import cv2
from random import randint
import numpy as np
from scipy.io import savemat


###### Configuration #######
# Set path for video to load
videoPathDir = "data/raw/videos/"

# Set path for output video
outputVideoDir= "data/processed/videos/"

# Set path for output data file
outputDataDir = "data/processed/"

# Specify the tracker type
trackerType = "CSRT"  

# Determine what filetypes to save as
saveMATLAB = True
saveNPY = True

#for loop for each frequency
dfre=0.1
fre=np.arange(0.1,3.0+dfre,dfre)


# Setup helper function for defining tracker
trackerTypes = ['BOOSTING', 'MIL', 'KCF','TLD', 'MEDIANFLOW', 'GOTURN', 'MOSSE', 'CSRT']

def createTrackerByName(trackerType):
  # Create a tracker based on tracker name
  if trackerType == trackerTypes[0]:
    tracker = cv2.TrackerBoosting_create()
  elif trackerType == trackerTypes[1]:
    tracker = cv2.TrackerMIL_create()
  elif trackerType == trackerTypes[2]:
    tracker = cv2.TrackerKCF_create()
  elif trackerType == trackerTypes[3]:
    tracker = cv2.TrackerTLD_create()
  elif trackerType == trackerTypes[4]:
    tracker = cv2.TrackerMedianFlow_create()
  elif trackerType == trackerTypes[5]:
    tracker = cv2.TrackerGOTURN_create()
  elif trackerType == trackerTypes[6]:
    tracker = cv2.TrackerMOSSE_create()
  elif trackerType == trackerTypes[7]:
    tracker = cv2.TrackerCSRT_create()
  else:
    tracker = None
    print('Incorrect tracker name')
    print('Available trackers are:')
    for t in trackerTypes:
      print(t)
 
  return tracker


#######################

for f in fre:
  videoPath = videoPathDir+"{:.1f}Hz.mp4".format(f)
  # Set output paths
  # Get video name without extension
  videoName = videoPath.split("/")[-1].split(".mp4")[0]
  outputVideoPath = outputVideoDir + videoName + "_" + trackerType + ".mp4"
  outputDataPath = outputDataDir + videoName + "_" + trackerType

  # Create a video capture object to read videos
  cap = cv2.VideoCapture(videoPath)
 
  # Read first frame
  success, frame = cap.read()
  # quit if unable to read the video file
  if not success:
    print('Failed to read video')
    sys.exit(1)


  ## Select boxes
  bboxes = []
  colors = [] 
 
  # OpenCV's selectROI function doesn't work for selecting multiple objects in Python
  # So we will call this function in a loop till we are done manually selecting all objects
  while True:
    # draw bounding boxes over objects
    # selectROI's default behaviour is to draw box starting from the center
    # when fromCenter is set to false, you can draw box starting from top left corner
    bbox = cv2.selectROI('MultiTracker', frame)
    bboxes.append(bbox)
    colors.append((randint(0, 255), randint(0, 255), randint(0, 255)))
    print("Press q to quit selecting boxes and start tracking")
    print("Press any other key to select next object")
    k = cv2.waitKey(0) & 0xFF
    if (k == 113):  # q is pressed
      break
  
  print('Selected bounding boxes {}'.format(bboxes))
  
  # Create MultiTracker object
  multiTracker = cv2.MultiTracker_create()

  # Initialize matrices to hold tracker data from bounding boxes with one row per frame and columns for coordinates (first page is x and second page is y coords) 
  # of bounding boxes (currently theres no correspondence in bounding boxes between trials so you need to manually match them up)
  numFrames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
  trackerData = np.zeros((numFrames, len(bboxes), 2))

  # Initialize video writer
  # Get video source size
  width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
  height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
  # Define the codec and create VideoWriter object
  fourcc = cv2.VideoWriter_fourcc(*'mp4v')  # Be sure to use lower case
  out = cv2.VideoWriter(outputVideoPath, fourcc, 20.0, (width, height))



  
  # Initialize MultiTracker
  for bbox in bboxes:
    multiTracker.add(createTrackerByName(trackerType), frame, bbox)

  # Process video and track objects
  frameCounter = 0
  while cap.isOpened():
    success, frame = cap.read()
    if not success:
      break
  
    # get updated location of objects in subsequent frames
    success, boxes = multiTracker.update(frame)
    # Compute tracker data
    for i, newbox in enumerate(boxes):
      trackerData[frameCounter, i, 0] = int(newbox[0] + newbox[2]/2)
      trackerData[frameCounter, i, 1] = int(newbox[1] + newbox[3]/2)
    # Update frame counter
    frameCounter += 1
  
    # draw tracked objects
    for i, newbox in enumerate(boxes):
      # draw new bounding box
      p1 = (int(newbox[0]), int(newbox[1]))
      p2 = (int(newbox[0] + newbox[2]), int(newbox[1] + newbox[3]))
      cv2.rectangle(frame, p1, p2, colors[i], 2, 1)
      # draw red center point of bounding box
      cv2.circle(frame, (int(newbox[0] + newbox[2]/2), int(newbox[1] + newbox[3]/2)), 3, (0, 0, 255), -1)
    
    # Write frame to output video
    out.write(frame)
      
  
    # show frame
    cv2.imshow('MultiTracker', frame)
  
    # quit on ESC button
    if cv2.waitKey(1) & 0xFF == 27:  # Esc pressed
      break

  # Write tracker data to specified filetypes
  if saveMATLAB:
    savemat(outputDataPath + ".mat", {'trackerData': trackerData})
  if saveNPY:
    np.save(outputDataPath + ".npy", trackerData)

  # Release video capture and writer
  cap.release()
  out.release()