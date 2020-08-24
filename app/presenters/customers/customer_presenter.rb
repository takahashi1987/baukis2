class CustomerPresenter < ModelPresenter
  delegate :email, to: :object

  def full_name
    object.family_name + " " + 
  end
end
