// OCVTessExample.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>

#include <string>
#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main(int argc, char* argv[])
{
	string outText;
	string imPath = argv[1];

	// Create Tesseract object
	tesseract::TessBaseAPI *ocr = new tesseract::TessBaseAPI();

	cout << ocr->Version() << endl;

	// Initialize tesseract to use English (eng) and the LSTM OCR engine. 
	//ocr->Init(NULL, "eng", tesseract::OEM_LSTM_ONLY);
	ocr->Init("tessdata", "eng", tesseract::OEM_LSTM_ONLY);

	// Set Page segmentation mode to PSM_AUTO (3)
	ocr->SetPageSegMode(tesseract::PSM_AUTO);
	// Open input image using OpenCV
	Mat im = cv::imread(imPath, IMREAD_COLOR);

	cv::imwrite("img.png", im);
	im = cv::imread("img.png");

	// Set image data
	ocr->SetImage(im.data, im.cols, im.rows, 3, im.step);

	// Run Tesseract OCR on image
	outText = string(ocr->GetUTF8Text());

	// print recognized text
	cout << outText << endl; // Destroy used object and release memory ocr->End();

	return EXIT_SUCCESS;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
