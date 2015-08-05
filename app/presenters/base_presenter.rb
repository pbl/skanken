# Base presenter class
class BasePresenter
  # Require the relevant ActiveModel modules
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def initialize(params = {}, with: [])
    # Extract the relevant params
    presenter_name = self.class.to_s.underscore
    attributes = params[presenter_name] || {}
    # For each class attribute assign the corresponding value in params
    self.class::ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
    with.each { |attribute| send("#{attribute}=", params[attribute]) }
  end

  # A presenter can't be persisted, like other ActiveModel objects..
  def persisted?
    false
  end
end
