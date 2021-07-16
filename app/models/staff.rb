class Staff < ActiveRecord::Base
    has_many :main_responsibility
    has_many :work_activity
end
