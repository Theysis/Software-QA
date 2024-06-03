require "minitest/autorun"

require_relative "./shape"

class ShapeTest < Minitest::Test

    # run before every test
    def setup 
        # set up test data used across tests in ShapeTest
        # data objects, populating database, open files and sockets, etc. 
    end

    # run after every test
    def teardown
        # clean up data to get a clean state
        # data object are garbbage collected automatically
        # need this to restore database, close files and sockets, etc.
    end

    def test_ping_minitest 
        assert true
    end

    def test_refute
        refute false
    end

    def test_assert_equal
        assert_equal 3+2, 5
        assert_equal 'hello', 'hello'
        assert_equal :symbol, :symbol
    end

    def test_same
        assert_same :symbol, :symbol
        refute_same 'hello', 'hello'
    end

    def test_include
        assert_includes [1,2], 1
    end

    def test_raises
        assert_raises "error" do
            raise "error"
        end
    end

    def test_kind_of
        assert_kind_of Integer, 1
    end
    
    def test_assert_in_delta
        assert_in_delta Math::PI, 22.0/7, 0.01
    end 

    def test_refute_respond_to 
        refute_respond_to 1, :area #1 does not have the method area
    end

    def test_square_area
        assert_equal 100, Square.new(10).area
    end

    def test_circle_area
        assert_in_delta Math::PI * 10 * 10, Circle.new(10).area
    end

    def test_composite_area
        composite = CompositeShape.new [Square.new(10), Circle.new(10)]
        assert_in_delta 100 + Math::PI * 10 * 10, composite.area 
    end

    def test_negative_raise_exception
        assert_raises "parameter must be a positive number" do
            Square.new(-1) 
        end
    end

    def test_string_raise_exception
        assert_raises "parameter must be a positive number" do
            Circle.new "100" 
        end
    end

    def test_composite_include
        s = Square.new(10)
        composite = CompositeShape.new [s, Circle.new(10)]
        assert_includes composite.components, s
    end
end

#minitest/spec
describe CompositeShape do
    describe '#area' do 
        it 'returns sum of areas of component shapes' do
            composite = CompositeShape.new [Square.new(10), Circle.new(10)]
            _(composite.area).must_be_close_to 100 + Math::PI * 10 * 10, 
              composite.area
        end
    end
end

# data driven through array.each
describe Square do
    describe '#area' do
        [
            [10, 100],
            [5, 25],
            [0, 0],
            [-100, 'parameter must be a positive number'],
            ['abc', 'parameter must be a positive number']
        ].each do |sl, ar|
            it 'returns area #{ar} for a side length #{sl}' do
                begin
                    _(Square.new(sl).area).must_be_close_to ar
                rescue => e
                    _(e.message).must_equal ar
                end
            end
        end
    end
end