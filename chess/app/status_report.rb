class StatusReport

  def self.report(move:, pieces:, board:)

    LOG.debug  "=== StatusReport.report"

    data = {
      valid: false,
      errors: [],
      b_check: false,
      b_mate: false,
      w_check: false,
      w_mate: false,
      move: move    
    }

    #do some checks...
    if pieces.data[:wK][:threats].count > 0
      data[:w_check] = true
      if pieces.data[:wK][:moves].count == 0
        data[:w_mate] = true
      end
    end

    if pieces.data[:bK][:threats].count > 0 
      data[:b_check] = true
      if pieces.data[:bK][:moves].count == 0
        data[:b_mate] = true
      end
    end

    data[:valid] = true

    data.each do |k,v|
      LOG.debug "#{k}: #{v}" unless k == :move
      if k == :move
        LOG.debug "move:"
        v.each do |k2,v2|
          LOG.debug "  #{k2}: #{v2}"
        end
      end
    end

    return data

  end

end