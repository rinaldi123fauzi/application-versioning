class Risiko <  ActiveRecord::Base
    has_many :rfc, dependent: :destroy
end
