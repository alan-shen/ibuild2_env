#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

int dolphin;
int bobcat;
module_param(dolphin, int , 0);
module_param( bobcat, int , 0);

static int alan_mask = 0xFF;
module_param_named(alan_mask, alan_mask, int, S_IRUGO | S_IWUSR | S_IWGRP);

static int hello_init(void)
{
	printk(KERN_ALERT "\n\n\nhello module init\n");
	printk(KERN_ALERT "dolphin = %d, bobcat = %d\n\n", dolphin, bobcat);
	return 0;
}

static void hello_exit(void)
{
	printk(KERN_ALERT "\n\n\nhello module exit\n\n\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_AUTHOR("shenpengru@gmail.com");
MODULE_AUTHOR("pengru.shen@borqs.com");
MODULE_DESCRIPTION("A demo module for test only.");
MODULE_ALIAS("helloalan");
//MODULE_LICENSE("Ducal BSD/GPL");
MODULE_LICENSE("shen");

