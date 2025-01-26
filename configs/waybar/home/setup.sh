#!/bin/bash
choice=$1

status="$(playerctl status)"
artist="$(playerctl metadata | grep artist | awk '{print $3 $4 $5}')"
title="$(playerctl metadata | grep title | awk '{print $3 $4 $5}')"
username="$(whoami)"
hostname="$(echo $HOSTNAME)"
tanggal="$(date "+%d")"
bulan="$(date "+%b")"
tahun="$(date "+%y")"

current_time=$(timedatectl | grep Local | awk '{print $5}' | cut -d':' -f1)


if [ $choice = status ]; then
	if [ $status = Playing ]; then
		echo ""
	else
		echo ""
	fi
fi


if [ $choice = greeting ]; then
	if [[ $current_time =~ ^[0-9]+$ ]]; then
  		if (( current_time >= 0 && current_time < 12 )); then
        echo "Good Morning,"
  		elif (( current_time >= 12 && current_time < 15 )); then
      		echo "Good Noon,"
  		elif (( current_time >= 15 && current_time < 18 )); then
      		echo "Good Afternoon,"
  		else
      		echo "Good Night,"
  		fi
	else
  		echo "Gagal mendapatkan waktu lokal"
	fi
fi

if [ $choice = title ]; then
	if [ $status != Playing ]; then
		echo $username
	else
		echo $title
	fi
fi

if [ $choice = artist ]; then
	if [ $status != Playing ]; then
		echo "@$hostname"
	else
		echo $artist
	fi
fi

if [ $choice = kiri ]; then
	if [ $status != Playing ]; then
		echo $tanggal
	else
		echo " "
	fi
fi

if [ $choice = tengah ]; then
	if [ $status != Playing ]; then
		echo $bulan
	else
		echo "Paus"
	fi
fi

if [ $choice = kanan ]; then
	if [ $status != Playing ]; then
		echo $tahun
	else
		echo " "
	fi
fi
