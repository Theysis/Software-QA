class Scenario
    attr :name, :clauses
    def initialize name="", clauses=[]
        @name = name
        @clauses = clauses
    end

    def Given message=""
        raise "Given: out of place" unless @clauses.empty? || @clauses.last.at(0) == 'Given'
        @clauses.append ['Given', message]

        yield if block_given?
        self
    end

    def And message= ""
        raise "And: must not be the first clause" if @clauses.empty?
        @clauses.append [@clauses.last[0], message]

        yield if block_given?
        self
    end

    def When message=""
        raise "When: out of place" unless @clauses.empty? || @clauses.last[0] != 'Then'
        @clauses.append ['When', message]

        yield if block_given?
        self
    end

    def Then message=""
        @clauses.append ['Then', message]

        yield if block_given?
        self
    end
end

