require_relative '../enumerable_methods'

describe '#my_each' do
  let(:array) { [1, 2, 3, 4, 5] }
  
  it 'with a block' do
    expect(array.my_each { |i| i * i }).to eql([1, 4, 9, 16, 25])
  end
  it 'without a block' do
    expect(array.my_each).to be_an(Enumerator)
  end
end

describe '#my_each_with_index' do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:arrs) { ['cat', 'dog', 'wombat'] }

  it 'with a block' do
    hash = {}
    expect(arrs.my_each_with_index{ |item, index| hash[item] = index}).to eql(nil)
  end
  it 'without a block' do
    expect(array.my_each).to be_an(Enumerator)
  end
end

describe '#my_select' do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:arr) { [12.2, 13.4, 15.5, 16.9, 10.2] }

  it 'with a block' do
    expect(array.my_select { |num| num.even? }).to eql([2, 4])
  end
  it 'with a block' do
    expect(new_arr = arr.my_select { |num| num.to_f > 13.3}).to eql([13.4, 15.5, 16.9])
  end
  it 'without a block' do
    expect(arr.my_select).to be_an(Enumerator)
  end
end

describe '#my_all?' do
  let(:array) { %w[ant bear cat] }
  let(:arr2) { [1, 2i, 3.14] }
  let(:arr3) { [nil, true, 99] }

  it 'with a block' do
    expect(array.my_all? { |word| word.length >= 3 }).to eql(true)
  end
  it 'with a block' do
    expect(array.my_all? { |word| word.length >= 4 }).to eql(false)
  end
  it 'Regex input' do
    expect(array.my_all?(/t/)).to eql(false)
  end
  it 'Class input' do
    expect(arr2.my_all?(Numeric)).to eql(true)
  end
  it 'nil/false input' do
    expect(arr3.my_all?).to eql(false)
  end
  it 'empty input' do
    expect([].my_all?).to eql(true)
  end
end

describe '#my_any?' do
  let(:array) { %w[ant bear cat] }
  let(:arr2) { [nil, true, 99] }

  it 'with a block' do
    expect(array.my_any? { |word| word.length >= 3 }).to eql(true)
  end
  it 'with a block' do
    expect(array.my_any? { |word| word.length >= 4 }).to eql(true)
  end
  it 'Regex input' do
    expect(array.my_any?(/d/)).to eql(false)
  end
  it 'Class input' do
    expect(arr2.my_any?(Integer)).to eql(true)
  end
  it 'nil/false input' do
    expect(arr2.my_any?).to eql(true)
  end
  it 'empty input' do
    expect([].my_any?).to eql(false)
  end
end

describe '#my_none?' do
  let(:array) { %w[ant bear cat] }
  let(:arr2) { [nil, true, 99] }
  let(:arr3) { [1, 3.14, 42] }

  it 'with a block' do
    expect(array.my_none? { |word| word.length == 5 }).to eql(true)
  end
  it 'with a block' do
    expect(array.my_none? { |word| word.length >= 4 }).to eql(false)
  end
  it 'Regex input' do
    expect(array.my_none?(/d/)).to eql(true)
  end
  it 'Class input' do
    expect(arr3.my_none?(Float)).to eql(false)
  end
  it 'empty input' do
    expect([].my_none?).to eql(true)
  end
  it 'nil/false input' do
    expect([nil].my_none?).to eql(true)
  end
  it 'nil/false input' do
    expect([nil, false].my_none?).to eql(true)
  end
  it 'nil/false input' do
    expect([nil, false, true].my_none?).to eql(false)
  end
end

describe '#my_count' do
  let(:ary) { [1, 2, 4, 2] }

  it 'without a block' do
    expect(ary.my_count).to eql(4)
  end
  it 'with an input' do
    expect(ary.my_count(2)).to eql(2)
  end
  it 'with a block' do
    expect(ary.my_count { |x| (x % 2).zero? }).to eql(3)
  end
end

describe '#my_map' do
  let(:array) { [1, 2, 3, 4] }

  it 'with a block' do
    expect(array.my_map { |i| i * i }).to eql([1, 4, 9, 16])
  end
  it 'without a block' do
    expect(array.my_map).to be_an(Enumerator)
  end
end

describe '#my_inject?' do
  let(:x) { (5..10) }

  it 'with a block' do
    expect(x.my_inject { |sum, n| sum + n }).to eql(45)
  end
  it 'with a symbol' do
    expect(x.my_inject :+).to eql(45)
  end
  it 'with an initial and a block' do
    expect(x.inject(1) { |product, n| product * n }).to eql(151200)
  end
  it 'with an initial and a symbol' do
    expect(x.my_inject(1, :*)).to eql(151200)
  end
  it 'empty input' do
    expect(longest = %w[cat sheep bear].inject { |memo, word| memo.length > word.length ? memo : word}).to eql('sheep')
  end
end
