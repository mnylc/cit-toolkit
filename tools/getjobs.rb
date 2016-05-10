#!/usr/bin/env ruby
# coding: utf-8
require 'csv'
require 'byebug'

CSV.foreach(ARGV[0], encoding: 'UTF-8') do |row|
  next if row[0] == 'Timestamp'

  # build fields.
  row.map! do |x|
    if x =~ %r{https*:\/\/[^\s]+}
      x.gsub!(%r{(https*:\/\/[^\s]+)}, '[\\1](\\1)')
    else
      x
    end
  end
  datebits = row[0].split(' ')[0].split('/')
  datestr = datebits[0] + ' ' + datebits[1].rjust(2, '0')
  datestr += ' ' + datebits[2].rjust(2, '0')
  frontmatter_datestr = datestr.tr(' ', '-')
  title = row[1]
  institution = row[2]
  description = row[3]
  description.gsub!('\*', "\n*") unless description.nil?
  description.gsub!(/(.)\n\*/, "\\1\n\n*") unless description.nil?
  resps = row[4]
  resps.gsub!('\*', "\n*") unless resps.nil?
  resps.gsub!(/(.)\n\*/, "\\1\n\n*") unless resps.nil?
  qualifications = row[5]
  qualifications.gsub!('\*', "\n*") unless qualifications.nil?
  qualifications.gsub!(/(.)\n\*/, "\\1\n\n*") unless qualifications.nil?
  compensation = row[6]
  compensation.gsub!('\*', "\n*") unless compensation.nil?
  compensation.gsub!(/(.)\n\*/, "\\1\n\n*") unless compensation.nil?
  location = row[7]
  url = row[8]
  to_apply = row[9]
  company_info = row[10]
  contact_info = row[11]
  #  byebug

  markdoc = <<HERE
---
layout: post
title:  "#{title} - #{institution}"
date:   #{frontmatter_datestr}
---

#{"### Description###\n\n" + description + "\n" unless description.eql? ""}

#{"### Responsibilities###\n\n" + resps + "\n" unless resps.eql? ""}

#{"### Qualifications###\n\n" + qualifications + "\n" unless qualifications.eql? ""}

#{"### Compensation###\n\n" + compensation + "\n" unless compensation.eql? ""}

#{"### Location###\n\n" + location + "\n" unless location.eql? ""}

#{"### URL###\n\n" + url unless url.eql? ""}

#{"### To Apply###\n\n" + to_apply + "\n" unless to_apply.eql? ""}

#{"### Company Information###\n\n" + company_info + "\n" unless company_info.eql? ""}

#{"### Contact Information###\n\n" + contact_info + "\n" unless contact_info.eql? ""}
HERE

  jfname = datestr + ' ' + title.upcase + ' ' + institution.upcase
  jfname.tr!('/ ().,&\'', '-')
  jfname.gsub!('--', '-')
  jfname += '.markdown'

  jobfile = File.open(jfname, 'w')
  jobfile.puts markdoc
  jobfile.close
end
