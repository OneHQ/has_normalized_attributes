ActiveRecord::Schema.define(:version => 0) do

  create_table "resources", :force => true do |t|
    t.string   "phone_attr"
    t.string   "ssn_attr"
    t.string   "zipcode_attr"
    t.string   "taxid_attr"
    t.string   "dollar_attr"
    t.string   "number_attr"
    t.string   "percent_attr"
    t.string   "spaces_attr"
    t.string   "strip_attr"
  end

end