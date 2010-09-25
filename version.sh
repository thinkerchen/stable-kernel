#!/bin/bash

unset BUILD

KERNEL_REL=2.6.35
STABLE_PATCH=5
KERNEL_PATCH=${KERNEL_REL}.${STABLE_PATCH}
DL_PATCH=patch-${KERNEL_PATCH}
ABI=5.1

if [ "${IS_LUCID}" ] ; then
BUILD+=l${ABI}
else
BUILD+=x${ABI}
fi

BUILDREV=1.0
DISTRO=cross

export KERNEL_REL BUILD RC_PATCH KERNEL_PATCH
export BRANCH REL
export BUILDREV DISTRO
