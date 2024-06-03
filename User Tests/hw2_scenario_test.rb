require 'minitest/autorun'
require 'minitest/spec'

require_relative './scenario'

describe Scenario do

    def setup 
        
    end

    # run after every test
    def teardown
        
    end

    # General test to ensure test loads correctly.
    # def test_ping_minitest 
    #     assert true
    # end 
    
    #1 tests creation of scenario with name and no clauses provided.
    def test_scenario_empty
        the_scenario = Scenario.new('the scenario')
        assert_equal 'the scenario', the_scenario.name
        assert_equal [], the_scenario.clauses
    end

    #2 Given must be first clause if present
    def test_given_first
        describe '# Given' do 
            it 'is listed first if present' do
                the_scenario = Scenario.new('the scenario') 
                the_scenario.Given('test')
                assert_match ['Given', 'test'], the_scenario.clauses[0]
                
                the_scenario2 = Scenario.new('the scenario')
                the_scenario2.When('test')
                refute_same ['Given', ''], the_scenario2.clauses[0]
            end
        end
        
    end

    #3 Tests when Given is after a when, should raise 'out of place' error
    def test_late_given
         assert_raises "Given: out of place" do
            the_scenario = Scenario.new('the scenario')
            the_scenario.When('test')
            the_scenario.Given('test2')
         end
    end

    #4 And is after a Given, 'And' is recorded as 'Given'
    def test_given_and 
        the_scenario = Scenario.new('the scenario') 
        the_scenario.Given('test')
        the_scenario.And('given 2')
        assert_equal ['Given', 'given 2'], the_scenario.clauses[1] 
    end

    # 5 And is the first clause added
    def test_and_first
        assert_raises "And: must not be the first clause" do
            the_scenario = Scenario.new('the scenario')
            the_scenario.And('test')
        end
    end

    #6 Tests if When can be first
    def test_when_first
        the_scenario = Scenario.new('the scenario')
        the_scenario.When('test')
        assert true
    end

    #7 And is after a When, 'And' is recorded as 'When'
    def test_when_and
        the_scenario = Scenario.new('the scenario') 
        the_scenario.When('test')
        the_scenario.And('when 2')
        assert_equal ['When', 'when 2'], the_scenario.clauses[1] 
    end

    #8 Tests if Then is first
    def test_then
        the_scenario = Scenario.new('the scenario')
        the_scenario.Then('test')
        assert true
    end

    #9 And is after a Then, 'And' is recorded as 'Then'
    def test_then_and
        the_scenario = Scenario.new('the scenario') 
        the_scenario.Then('test')
        the_scenario.And('then 2')
        assert_equal ['Then', 'then 2'], the_scenario.clauses[1] 
    end

    #10 Tests a standard Given-When-Then scenario.
    def test_full_scenario
        the_scenario = Scenario.new('the scenario')
        the_scenario.Given('give')
        the_scenario.When('when')
        the_scenario.Then('then')
        assert true
    end
end