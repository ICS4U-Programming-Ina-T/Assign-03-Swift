//
// Recursion.swift
//
// Created by Ina Tolo
// Created on 2022-4-11
// Version 1.0
// Copyright (c) 2022 Ina Tolo. All rights reserved.
//
// The Recursion program implements an application that
// uses a recursive function to print an hourglass pattern
// of asterisks based on the number entered by the user.

import Foundation

// uses recursion to display hourglass pattern of stars.
func recursiveStar(userNum: Int, space: Int) {
    print(hourglassFormat(userNum: userNum, space: space))

    if userNum > 1 {
        recursiveStar(userNum: userNum - 1, space: space + 1)
        print(hourglassFormat(userNum: userNum, space: space))
    } else if userNum == 1 {
        print(hourglassFormat(userNum: userNum, space: space))
    }
}

// configures the format for the hourglass pattern.
func hourglassFormat(userNum: Int, space: Int) -> String {
    return String(repeating: " ", count: space)
        + String(repeating: "* ", count: userNum)
}

// stores exception at runtime
enum MyError: Error {
    case runtimeError(String)
}

// function that throws exception
func catchString() throws {
    throw MyError.runtimeError("\nValue is invalid!")
}

// main code for program

// declaring variables
var userNumString: String = ""
var userNumInt: Int
var starPatternUser: String = ""
var starList: String = ""
var zero: Int = 0
var newNum: Int = 1
let text = ""
var arrayToString: String = ""

// displays opening message
print("This program will create an hourglass pattern of stars based on the entered integer.")
print()

print("Enter a positive integer: ", terminator: "")
userNumString = readLine()!

do {
    userNumInt = Int(userNumString) ?? 0

    if userNumInt != Int(userNumString) {
        try catchString()
    }

    if userNumInt > 0 {

        let temp: Int = userNumInt

        print("\nDone forming star pattern. Look below and check the output file.")
        print("--------------------------")

        recursiveStar(userNum: userNumInt, space: 0)

        // adds top half of hourglass to list
        for topCounter in 0...userNumInt * 4 {
            if userNumInt < 0 {
                break
            }

            starPatternUser = hourglassFormat(userNum: userNumInt, space: zero)

            if userNumInt != 0 {
                if topCounter != userNumInt - 1 {
                   starList.append(starPatternUser + "\n")
                } else {
                   starList.append(starPatternUser + "\n")
                }
            }

            userNumInt -= 1
            zero += 1
        }

        zero -= 1

        // adds bottom half of hourglass to list
        for bottomCounter in 0..<temp {
            zero -= 1
            starPatternUser = hourglassFormat(userNum: newNum, space: zero)

            if bottomCounter != temp - 1 {
                starList.append(starPatternUser + "\n")
            } else {
                starList.append(starPatternUser)
            }
            newNum += 1
        }

        // converts list with hourglass pattern to an array
        let starArray: [String] = starList.components(separatedBy: "\n")

        // writes the new pattern of strings to the output file
        try text.write(to: URL(fileURLWithPath: "/home/runner/Assign-03-Swift/output.txt"),
            atomically: false, encoding: .utf8)

        if let fileWriter = try? FileHandle(forUpdating:
            URL(fileURLWithPath: "/home/runner/Assign-03-Swift/output.txt")) {
            // adds each string to the output file
            for stringFormat in 0..<starArray.count {
                if stringFormat != starArray.count - 1 {
                    arrayToString = starArray[stringFormat] + "\n"
                } else {
                    arrayToString = starArray[stringFormat]
                }
                fileWriter.seekToEndOfFile()
                fileWriter.write(arrayToString.data(using: .utf8)!)
            }
            fileWriter.closeFile()
        }

        print("--------------------------")

    } else {
        // catches negative numbers
        print("\nValue must be greater than 0.")
    }
} catch MyError.runtimeError(let errorMessage) {
    // catches invalid strings
    print(errorMessage)
    print()
}
