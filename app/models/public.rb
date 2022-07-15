module Public
  belongs_to :cart
  def self.table_name_prefix
    'public_'
  end
end
