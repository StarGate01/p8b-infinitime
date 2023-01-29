#!/usr/bin/env bash

cd "${0%/*}"

source ./infinitime_version.sh

cd ../InfiniTime

itctl res load "build/src/resources/infinitime-resources-$INFINITIME_VERSION.zip"