class UnitTeam < Group
  validates_presence_of :begin_date, :end_date, :quantity
  validates_numericality_of :quantity
end
