class History < ActiveRecord::Base
  belongs_to :lender #ie. loans as lender
  belongs_to :borrower #ie. loans as borrower
end
