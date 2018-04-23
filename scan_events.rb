# Set encoding to utf-8
# encoding: UTF-8
#
# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
#
# Copyright (c) 2017 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 3.0 of the License, or (at your option)
# any later version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
#

require 'bbbevents'
require 'nokogiri'

def get_all_user_related_meeting_data(user_id)
	user_regx = /<externalUserId>#{user_id}<\/externalUserId>/

	recordings_dir = Dir.open "./raw"
	#recordings_dir = Dir.open "/var/bigbluebutton/recording/raw"
	data = []

	recordings_dir.each do |recording_dir|
		path = File.absolute_path("./raw/" + recording_dir + "/events.xml")
		if File.exist?(path)
      xml_document = File.open(path) { |f| Nokogiri::XML(f) }
      if xml_document.xpath("//event").any?
        #reccord is a bbbevents RecordingData object
        reccord = BBBEvents.parse(File.new(path))
        data.push reccord
      end
		end
	end

  data.each do |meeting_inv|
  	 #meeting_inv is a bbbevents RecordingData object
	  print_user_data(meeting_inv, user_id)
  end

  return
end

def print_user_data(recordingData, user_id)
  meeting_id = recordingData.data[:meeting_id]
  puts ""
  puts "User summary for meeting #{meeting_id}: " + recordingData.data[:attendees][user_id].to_s
  history_hash = recordingData.user_history(user_id)
  if history_hash != nil
    puts "User history for meeting #{meeting_id}: "
    history_hash.keys.sort.each do |timestamp|
      events_for_time = history_hash[timestamp]
      if events_for_time.class.name == "String"
        puts "#{convert_date(timestamp)}: #{events_for_time}"
      else
        events_for_time.each do |event|
          puts "#{convert_date(timestamp)}: #{event}"
        end
      end
    end
  end
end

def convert_date(t)
  Time.at(t.to_i).strftime("%m/%d/%Y %H:%M:%S")
end