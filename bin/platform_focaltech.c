/*
 * platform_focaltech.c: gt5x0x platform data initilization file
 *
 * (C) Copyright 2013 Intel Corporation
 * Author:
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2
 * of the License.
 */

#include <linux/gpio.h>
#include <linux/lnw_gpio.h>
#include <asm/intel-mid.h>
#include <linux/ft5x06_ts.h>
#include "platform_focaltech.h"

void *focaltech_platform_data(void *info)
{
	static struct ft5x0x_platform_data focaltech_pdata;

	focaltech_pdata.numtouch       = 10;
	focaltech_pdata.x_max          = 768;
	focaltech_pdata.y_max          = 1024;
	focaltech_pdata.irqflags       = 0x00000002;
	focaltech_pdata.reset          = 58;
	focaltech_pdata.irq            = 62;

	return &focaltech_pdata;
}
