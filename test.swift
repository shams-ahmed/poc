#!/usr/bin/env xcrun swift

import Foundation

print("Hello Shams from test.swift file!")

let process = ProcessInfo.processInfo
let environment = process.environment
let arguments = process.arguments

print("Environment")
environment.forEach { print($0) }

print("")

print("Arguments")
arguments.forEach { print($0) }
