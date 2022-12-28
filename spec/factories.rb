FactoryBot.define do
    factory(:note) do
        codigo { Faker::Number.number(digits: 8).to_s }
        valor { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    end

    factory(:product) do
        note
        codigo { Faker::Number.number(digits: 8).to_s }
    end
end