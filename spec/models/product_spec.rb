require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    # Validate product with all fields set will save successfully
    it 'saves successfully with all four fields set' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 100,
        quantity: 10,
        category: @category
      )
      expect(@product.save).to be_truthy
    end

    # Presence validations for each field
    # NAME validation
    it 'is not valid without a name' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: nil,
        price_cents: 100,
        quantity: 10,
        category: @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    # PRICE validation
    it 'is not valid without a price' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: nil,
        quantity: 10,
        category: @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    # QUANTITY validation
    it 'is not valid without a quantity' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 100,
        quantity: nil,
        category: @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    # CATEGORY validation
    it 'is not valid without a category' do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 100,
        quantity: 10,
        category: nil
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
