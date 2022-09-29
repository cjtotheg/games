#interpreter is parent class to the pieces that validate moves

module Chess

  class Interpreter

    def space_to_strings(key:, val:)
      {"loc" => "#{key}", "occ" => "#{val}"}
    end

  end

end
