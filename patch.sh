#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"
#git="git am --whitespace=fix"

if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

kernel_org_down () {

echo "Applying: 3.0.5 Patch"
patch -s -p1 < "${DIR}/patches/stable/patch-3.0.4-5"
echo "Applying: 3.0.6 Patch"
patch -s -p1 < "${DIR}/patches/stable/patch-3.0.5-6"

}

bugs_trivial () {
echo "bugs and trivial stuff"

patch -p1 -R < "${DIR}/patches/trivial/0001-staging-rt2860sta-and-rt2870sta-Remove-drivers-repla.patch"

#Bisected from 2.6.35 -> 2.6.36 to find this..
#This commit breaks some lcd monitors..
#rcn-ee Feb 26, 2011...
#Still needs more work for 2.6.38, causes:
#[   14.962829] omapdss DISPC error: GFX_FIFO_UNDERFLOW, disabling GFX
patch -s -p1 < "${DIR}/patches/trivial/0001-Revert-OMAP-DSS2-OMAPFB-swap-front-and-back-porches-.patch"

patch -s -p1 < "${DIR}/patches/trivial/0001-kbuild-deb-pkg-set-host-machine-after-dpkg-gencontro.patch"

#should fix gcc-4.6 ehci problems..
patch -s -p1 < "${DIR}/patches/trivial/0001-USB-ehci-use-packed-aligned-4-instead-of-removing-th.patch"

}

dss2_next () {
echo "dss2 from for-next"

}

dspbridge_next () {
echo "dspbridge from for-next"

}

omap_fixes () {
echo "omap fixes"

}

for_next () {
echo "for_next from tmlind's tree.."

patch -s -p1 < "${DIR}/patches/beagle/0001-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch"
}

sakoman () {
echo "sakoman's patches"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0006-OMAP-DSS2-add-bootarg-for-selecting-svideo-or-compos.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0007-video-add-timings-for-hd720.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0008-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.40/0009-drivers-input-touchscreen-ads7846-return-ENODEV-if-d.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0014-soc-codecs-Enable-audio-capture-by-default-for-twl40.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0015-soc-codecs-twl4030-Turn-on-mic-bias-by-default.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0016-RTC-add-support-for-backup-battery-recharge.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0017-ARM-OMAP2-mmc-twl4030-move-clock-input-selection-pri.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0018-Add-power-off-support-for-the-TWL4030-companion.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0019-ARM-OMAP-Add-twl4030-madc-support-to-Beagle.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0020-ARM-OMAP-Add-twl4030-madc-support-to-Overo.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0021-Enabling-Hwmon-driver-for-twl4030-madc.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0022-mfd-twl-core-enable-madc-clock.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0023-rtc-twl-Switch-to-using-threaded-irq.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0025-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0026-OMAP-Overo-Add-support-for-spidev.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0027-unionfs-Add-support-for-unionfs-2.5.9.patch"

patch -s -p1 < "${DIR}/patches/sakoman/3.0.0/0029-OMAP3-beagle-add-support-for-expansionboards.patch"

#TESTING
#patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0030-omap-beagle-Add-support-for-1GHz.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0031-omap-Change-omap_device-activate-dectivate-latency-m.patch"
patch -s -p1 < "${DIR}/patches/sakoman/3.0.0/0032-omap-overo-Add-opp-init.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0033-ARM-OMAP-Overo-remove-duplicate-call-to-overo_ads784.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0035-mtd-nand-Eliminate-noisey-uncorrectable-error-messag.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0046-OMAP3-SR-make-notify-independent-of-class.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0047-OMAP3-SR-disable-interrupt-by-default.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0048-OMAP3-SR-enable-disable-SR-only-on-need.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0049-OMAP3-SR-fix-cosmetic-indentation.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0050-OMAP-CPUfreq-ensure-driver-initializes-after-cpufreq.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0051-OMAP-CPUfreq-ensure-policy-is-fully-initialized.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0052-OMAP3-PM-CPUFreq-driver-for-OMAP3.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0053-OMAP-PM-CPUFREQ-Fix-conditional-compilation.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0054-cpufreq-fixup-after-new-OPP-layer-merged.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0055-OMAP-cpufreq-Split-OMAP1-and-OMAP2PLUS-CPUfreq-drive.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0056-OMAP2PLUS-cpufreq-Add-SMP-support-to-cater-OMAP4430.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0057-OMAP2PLUS-cpufreq-Fix-typo-when-attempting-to-set-mp.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0058-cpufreq-helpers-for-walking-the-frequency-table.patch"

patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0060-OMAP2-cpufreq-free-up-table-on-exit.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0061-OMAP2-cpufreq-handle-invalid-cpufreq-table.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0062-OMAP2-cpufreq-minor-comment-cleanup.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0063-OMAP2-cpufreq-use-clk_init_cpufreq_table-if-OPPs-not.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0064-OMAP2-cpufreq-use-cpufreq_frequency_table_target.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0065-OMAP2-cpufreq-fix-freq_table-leak.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0066-OMAP2-clockdomain-Add-an-api-to-read-idle-mode.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0067-OMAP2-clockdomain-Add-SoC-support-for-clkdm_is_idle.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0068-OMAP2-PM-Initialise-sleep_switch-to-a-non-valid-valu.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0069-OMAP2-PM-idle-clkdms-only-if-already-in-idle.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0070-OMAP2-hwmod-Follow-the-recomended-PRCM-sequence.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0071-OMAP-Serial-Check-wk_st-only-if-present.patch"
patch -s -p1 < "${DIR}/patches/sakoman/2.6.39/0072-omap3-Add-basic-support-for-720MHz-part.patch"

}

musb () {
echo "musb patches"
patch -s -p1 < "${DIR}/patches/musb/0001-default-to-fifo-mode-5-for-old-musb-beagles.patch"
}

micrel () {
echo "micrel patches"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/01_eeprom_93cx6_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/02_eeprom_93cx6_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/03_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.38/04_ksz8851_2.6.38.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/06_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/07_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/08_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/09_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/10_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/11_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/12_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/15_ksz8851_2.6.35.patch"
patch -s -p1 < "${DIR}/patches/micrel/linux-2.6.35/18_ksz8851_2.6.35.patch"

}

beagle () {
echo "beagle patches"
patch -s -p1 < "${DIR}/patches/arago-project/0001-omap3-Increase-limit-on-bootarg-mpurate.patch"
patch -s -p1 < "${DIR}/patches/display/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"

}

igepv2 () {
echo "igepv2 board related patches"
}

devkit8000 () {
echo "devkit8000"
patch -s -p1 < "${DIR}/patches/devkit8000/0001-arm-omap-devkit8000-for-lcd-use-samsung_lte_panel-2.6.37-git10.patch"
}

touchbook () {
echo "touchbook patches"
patch -s -p1 < "${DIR}/patches/touchbook/0001-omap3-touchbook-remove-mmc-gpio_wp.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0002-omap3-touchbook-drop-u-boot-readonly.patch"
patch -s -p1 < "${DIR}/patches/touchbook/0001-touchbook-add-madc.patch"
#patch -s -p1 < "${DIR}/patches/touchbook/0002-touchbook-add-twl4030-bci-battery.patch"
}

omap4 () {
echo "omap4 related patches"
patch -s -p1 < "${DIR}/patches/panda/0001-OMAP4-DSS2-add-dss_dss_clk.patch"
patch -s -p1 < "${DIR}/patches/panda/0001-panda-fix-wl12xx-regulator.patch"
}

sgx () {
echo "merge in ti sgx modules"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.02-Kernel-Modules.patch"
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-enable-driver-building.patch"

#3.01.00.06
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.06-into-TI-3.01.00.02.patch"

#3.01.00.07 'the first wget-able release!!'
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-3.01.00.07-into-TI-3.01.00.06.patch"

#4.00.00.01 adds ti8168 support, drops bc_cat.c patch
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.00.00.01-into-TI-3.01.00.07.patch"

#4.03.00.01
#Note: git am has problems with this patch...
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.01-into-TI-4.00.00.01.patch"

#4.03.00.02 (main *.bin drops omap4)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-Merge-TI-4.03.00.02-into-TI-4.03.00.01.patch"

#4.03.00.02
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.32-PSP.patch"

#4.03.00.02 + 2.6.38-merge (2.6.37-git5)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-merge-AUTOCONF_INCLUD.patch"

#4.03.00.02 + 2.6.38-rc3
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.38-rc3-_console_sem-to-c.patch"

#4.03.00.01
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.01-add-outer_cache.clean_all.patch"

#4.03.00.02
#omap3 doesn't work on omap3630
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-use-omap3630-as-TI_PLATFORM.patch"

#4.03.00.02 + 2.6.39 (2.6.38-git2)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.39-rc-SPIN_LOCK_UNLOCKED.patch"

#4.03.00.02 + 2.6.40 (2.6.39-git11)
patch -s -p1 < "${DIR}/patches/sgx/0001-OMAP3-SGX-TI-4.03.00.02-2.6.40-display.h-to-omapdss..patch"
}

#kernel_org_down

bugs_trivial

#for_next tree's
dss2_next
omap_fixes
#dspbridge_next
for_next

#work in progress
#

#external tree's
sakoman
musb
micrel

#random board patches
beagle
igepv2
devkit8000
touchbook

#omap4/dvfs still needs more testing..
omap4

#no chance of being pushed ever tree's
sgx

echo "patch.sh ran successful"

