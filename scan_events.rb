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

  # Parse events.
  rec = BBBEvents.parse("#{raw_archive_dir}/events.xml")

	recordings_dir.each do |recording_dir|
		path = File.absolute_path("./raw/" + recording_dir + "/events.xml")


		if File.exist?(path)
      reccord = BBBEvents.parse(path)
      puts reccord.class.name
=begin
			event_file = File.readlines("./raw/" + recording_dir + "/events.xml")
			found = false
			event_file.each do |line|
				if user_regx.match(line)
					found = true 
					break
				end
			end

			if found
				xml_document = File.open(path) { |f| Nokogiri::XML(f) }
				data_for_meeting_file = MeetingInvolvement.new(xml_document, user_id)
				puts data_for_meeting_file
				data.push(data_for_meeting_file)
			end
=end
		end
	end
	return data
end

#data should be an array of Meeting Involvement objects
def print_data(data)
  data.each do |meeting_inv|
    
  end
end





=begin	

<event timestamp="164650380" module="PARTICIPANT" eventname="ParticipantJoinEvent">
    <userId>w_5vxrflelmi6q</userId>
    <externalUserId>student_id_382573058475493753</externalUserId>
    <role>MODERATOR</role>
    <name>User 2232075</name>
  </event>



 <event timestamp="164807112" module="PARTICIPANT" eventname="ParticipantJoinEvent">
    <userId>w_xcgcoqhsxj24</userId>
    <externalUserId>student_id_382573058475493753</externalUserId>
    <role>VIEWER</role>
    <name>User 2232075</name>
  </event>


children for event node:
children= [
	#<Nokogiri::XML::Text:0x2ae6f30bd164 "\n    ">,

	#<Nokogiri::XML::Element:0x2ae6f30bd088 name="userId" 
		children=[#<Nokogiri::XML::Text:0x2ae6f30bce30 "w_xcgcoqhsxj24">]
	>, 

	#<Nokogiri::XML::Text:0x2ae6f30bcc28 "\n    ">, 

	#<Nokogiri::XML::Element:0x2ae6f30bcb38 name="externalUserId" 
		children=[#<Nokogiri::XML::Text:0x2ae6f30bc8f4 "student_id_382573058475493753">]
	>, 

	#<Nokogiri::XML::Text:0x2ae6f30bc700 "\n    ">, 

	#<Nokogiri::XML::Element:0x2ae6f30bc610 name="role" 
		children=[#<Nokogiri::XML::Text:0x2ae6f30bc3a4 "VIEWER">]
	>, 

	#<Nokogiri::XML::Text:0x2ae6f30bc19c "\n    ">, 

	#<Nokogiri::XML::Element:0x2ae6f30bc0c0 name="name" 
		children=[#<Nokogiri::XML::Text:0x2ae6f30b3ed4 "User 2232075">]
	>,

	 #<Nokogiri::XML::Text:0x2ae6f30b3d30 "\n  ">]



=end