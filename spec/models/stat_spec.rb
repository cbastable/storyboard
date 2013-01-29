# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :integer
#  rated      :boolean          default(FALSE)
#

require 'spec_helper'

describe Stat do
  pending "add some examples to (or delete) #{__FILE__}"
end
