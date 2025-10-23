#!/bin/bash
#to elevate CPU Utilization on the instance for test the auto-scaling group behavior

sudo yum install stress -y
stress -c 4