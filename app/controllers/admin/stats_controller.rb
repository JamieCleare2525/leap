# Leap - Electronic Individual Learning Plan Software
# Copyright (C) 2014 South Devon College

# Leap is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Leap is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with Leap.  If not, see <http://www.gnu.org/licenses/>.

class Admin::StatsController < ApplicationController

  before_filter :admin_page

  def index
    stats = Hash.new
    stats[:ever] = Event.group(:eventable_type).count
    stats[:this_week] = Event.group(:eventable_type).where(:event_date => Time.now.all_week).count
    stats[:this_month] = Event.group(:eventable_type).where(:event_date => Time.now.all_month).count
    render :json=> stats
  end

end