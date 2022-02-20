#!/usr/bin/env bash
TANGGAL=$(date +"%F-%S")
START=$(date +"%s")
# Info
KERNEL="StormBreaker-Test"
DEVICE="Surya"
KERNELTYPE="rev.0.1"
KERNELNAME="${KERNEL}-${DEVICE}-${KERNELTYPE}-$(date +%y%m%d-%H%M)"
TEMPZIPNAME="${KERNELNAME}-unsigned.zip"
ZIPNAME="${KERNELNAME}.zip"
# Telegram
chat_id="-1001786450765" # Group/channel chatid (use rose/userbot to get it)
token="5136571256:AAEVb6wcnHbB358erxRQsP4crhW7zNh_7p8"

# sticker plox
function sticker() {
    curl -s -X POST "https://api.telegram.org/bot$token/sendSticker" \
        -d sticker="CAADBQADVAADaEQ4KS3kDsr-OWAUFgQ" \
        -d chat_id=$chat_id
}

# Send info plox channel
function sendinfo() {
    curl -s -X POST "https://api.telegram.org/bot$token/sendMessage" \
        -d chat_id=$chat_id \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=MARKDOWN" \
        -d text="*CI Build #$CIRCLE_BUILD_NUM Triggered*" \
	"Compiling with *$(nproc --all)* CPUs" \
	"-----------------------------------------" \
	"*Compiler ver:* ${CSTRING}" \
	"*Device:* ${DEVICE}" \
	"*Kernel name:* ${KERNEL}" \
	"*Build ver:* ${KERNELTYPE}" \
	"*Linux version:* $(make kernelversion)" \
	"*Branch:* ${CIRCLE_BRANCH}" \
	"*Clocked at:* ${NOW}" \
	"*Latest commit:* ${LATEST_COMMIT}" \
 	"------------------------------------------" \
	"${LOGS_URL}"
}

sticker
sendinfo
