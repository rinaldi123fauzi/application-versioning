class Category <  ActiveRecord::Base
    has_many :rfc, dependent: :destroy
end
