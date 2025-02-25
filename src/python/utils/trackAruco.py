import cv2
import os
import numpy as np

# ENTER YOUR REQUIREMENTS HERE:
ARUCO_DICT = cv2.aruco.DICT_4X4_250
SQUARES_VERTICALLY = 5
SQUARES_HORIZONTALLY = 5
MARKER_LENGTH = 0.08
# ...
videoPath = './data/raw/CameraCalibration/vids/SampleArucoTrackingVid.mp4'
testFrame = './data/raw/CameraCalibration/imgs/calibFrame_10.jpg'



def detect_pose(image, camera_matrix, dist_coeffs):
    # Undistort the image
    undistorted_image = cv2.undistort(image, camera_matrix, dist_coeffs)

    # Denoise the image using bilateral filtering
    undistorted_image = cv2.bilateralFilter(undistorted_image, 9, 75, 75)

    # Define the aruco dictionary and parameters
    dictionary = cv2.aruco.getPredefinedDictionary(ARUCO_DICT)
    parameters = cv2.aruco.DetectorParameters()

    # Detect the markers
    marker_corners, marker_ids, _ = cv2.aruco.detectMarkers(undistorted_image, dictionary, parameters=parameters)

    # If markers are detected, draw their axes
    if marker_ids is not None:
        for i in range(len(marker_ids)):
            rvec, tvec, _ = cv2.aruco.estimatePoseSingleMarkers(marker_corners[i], MARKER_LENGTH, camera_matrix, dist_coeffs)
            cv2.drawFrameAxes(undistorted_image, camera_matrix, dist_coeffs, rvec, tvec, MARKER_LENGTH)
    
    return undistorted_image


def main():
# Read in the camera matrix and distortion coefficients
    camera_matrix = np.load('./data/models/CameraCalibration/camera_matrix.npy')
    dist_coeffs = np.load('./data/models/CameraCalibration/dist_coeffs.npy')

    # # Load the test frame
    # frame = cv2.imread(testFrame)
    
    # # Detect the pose of the markers
    # output_frame = detect_pose(frame, camera_matrix, dist_coeffs)

    # # Display the output frame
    # cv2.imshow('Output Frame', output_frame)
    # cv2.waitKey(0)
    # cv2.destroyAllWindows()


    # Load the video
    cap = cv2.VideoCapture(videoPath)

    # cv2.resizeWindow('image', 640, 360)

    # Iterate through the video
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        # Detect the pose of the markers
        output_frame = detect_pose(frame, camera_matrix, dist_coeffs)

        # Display the output frame
        cv2.imshow('image', output_frame)
        cv2.namedWindow('image', cv2.WINDOW_AUTOSIZE)

        
        # Break the loop if 'q' is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

main()
