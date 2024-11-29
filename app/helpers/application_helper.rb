module ApplicationHelper
  def paginate(collection, options = {})
    options[:remote] ||= false # Set default to false for non-AJAX contexts
    super(collection, **options) # Use Ruby's double splat operator to handle options correctly
  end
end
