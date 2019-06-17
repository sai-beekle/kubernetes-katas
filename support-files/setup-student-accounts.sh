#!/bin/bash
STUDENT_COUNT=$1
SOURCE_USER=$2
PASSWORD=student-$(date +%D | tr '/' '-')


if [ -z "${STUDENT_COUNT}" ] || [ -z "${SOURCE_USER}" ] ; then
  echo
  echo "Usage: $0 STUDENT_COUNT USER_NAME_WITH_K8S_ACCESS_FOR_SOURCE"
  echo 
  exit 1
fi

echo
for i in $(seq -w 1 ${STUDENT_COUNT}); do
  STUDENT_NAME=student-${i}
  echo "Creating user: student-${i} with password: ${PASSWORD}"
  useradd -m ${STUDENT_NAME}
  echo "${PASSWORD}" | passwd --stdin ${STUDENT_NAME}
  cp -r /home/${SOURCE_USER}/.kube /home/${STUDENT_NAME}/
  chown -R  ${STUDENT_NAME}:${STUDENT_NAME} /home/${STUDENT_NAME}
done

