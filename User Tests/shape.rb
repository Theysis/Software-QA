module MustBePositiveNumber
    def check_positive
        raise "parameter must be a positive number" unless 
        get_parameter.is_a?(Numeric) && get_parameter >= 0 
    end
end

class Square
include MustBePositiveNumber
    def initialize side_length = 0
        @side_length = side_length
        check_positive
    end

    def area
        @side_length * @side_length
    end
    
    def get_parameter
        @side_length
    end
end

class Circle
    include MustBePositiveNumber
    def initialize radius = 0
        @radius = radius
        check_positive
    end

    def area
        Math::PI * @radius * @radius 
    end

    def get_parameter
        @radius
    end
end

class CompositeShape
    attr :components
    def initialize components = []
        @components = components
    end

    def area
        # sum = 0.0
        # @components.each { |shape| sum += shape.area}
        # sum
        @components.inject(0) {|sum, shape| sum + shape.area}
    end
end