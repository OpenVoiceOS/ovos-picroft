#!/bin/bash

get_variables () {
    ROOT_PART_DEV=$(findmnt / -o source -n)
    ROOT_PART_NAME=$(echo "$ROOT_PART_DEV" | cut -d "/" -f 3)
    ROOT_DEV_NAME=$(echo /sys/block/*/"${ROOT_PART_NAME}" | cut -d "/" -f 4)
    ROOT_DEV="/dev/${ROOT_DEV_NAME}"
    ROOT_PART_NUM=$(cat "/sys/block/${ROOT_DEV_NAME}/${ROOT_PART_NAME}/partition")
}

get_variables

growpart $ROOT_DEV $ROOT_PART_NUM
resize2fs $ROOT_PART_DEV

rm /opt/ovos/resize_fs
