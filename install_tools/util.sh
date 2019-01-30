#! /usr/bin/env bash

CURRENT_DIR=$(cd `dirname ${BASH_SOURCE[0]}` && pwd)
source ${CURRENT_DIR}/cecho.sh

## info
function INFO()
{
  local msg=$1
  cecho -green "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S%z')] $@" 
}

## warning
function WARN()
{
  local msg=$1
#  cecho -yellow "[WARN] ${msg}"
  cecho -yellow "[WARN] [$(date +'%Y-%m-%dT%H:%M:%S%z')] $@" 
}

## error
function ERROR()
{
  local msg=$1
  #cecho -red "[ERROR] ${msg}"
  cecho -red "[ERROR] [$(date +'%Y-%m-%dT%H:%M:%S%z')] $@" 
}


#INFO "info"
#WARN "warn"
#ERROR "error"

