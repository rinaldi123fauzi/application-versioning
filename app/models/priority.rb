class Priority <  ActiveRecord::Base
    has_many :rfc, dependent: :destroy
end
