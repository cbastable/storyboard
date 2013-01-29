# == Schema Information
#
# Table name: stories
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  title              :string(255)
#  blurb              :string(255)
#  content            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_genre_id   :integer
#  secondary_genre_id :integer
#  tertiary_genre_id  :integer
#  upvotes            :integer
#

require 'spec_helper'

describe Story do
  pending "add some examples to (or delete) #{__FILE__}"
end
