module ApplicationHelper
    def number_to_currency(number)
            ActiveSupport::NumberHelper.number_to_currency(number, 
            precision: 2, unit: 'R$', separator: ',')
    end
end
