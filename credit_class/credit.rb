class Credit

  attr_accessor :rezult, :percent, :summa, :paymeth, :datetime, :sum_per, :sum_crd


  def initialize percent, summa, paymeth, datetime
    @percent  = percent.to_i
    @summa 		= summa.to_i * 100
    @paymeth 	= paymeth.to_i
    @datetime = datetime.to_i
    @rezult   = []
    @sum_per  = 0
    @sum_crd  = 0
  end

  def standart
    ostatok = @summa.to_f
    osnovnoy_dolg = pogashenie_credita(@summa, @datetime).round(2)
    1.upto(@datetime) do | i |
      part = []
      part[0] =  i 	#номер платежа
      part[1] = osnovnoy_dolg  #погашение кредита
      part[2] = np_standart(ostatok, @percent) # погашение процентов
      ostatok = (ostatok - osnovnoy_dolg)
      part[3] = (part[1] + part[2]) #общий взнос
      part[4] = ostatok	#остаток кредита

      @rezult << prety(part)
    end
    @sum_per, @sum_crd = get_sum @rezult, @sum_per, @sum_crd
  end

  def annuitet
    ostatok = @summa.to_f
    percent = ps @percent
    obshiy_vznos = p_annuitet(ostatok, percent, @datetime)
    1.upto(@datetime) do | i |
      part = []
      part[0] = i 	#номер платежа
      part[2] = (ostatok * percent)
      ostatok = ostatok - (obshiy_vznos - part[2])
      part[3] = obshiy_vznos
      part[1] = part[3] - part[2]
      part[4] = ostatok #остаток кредита

      @rezult << prety(part)
    end
    @sum_per, @sum_crd = get_sum @rezult, @sum_per, @sum_crd
  end


  private

  #возврат основного долга
  def pogashenie_credita summa, srok
    summa.to_f / srok.to_f
  end

  #начисленные проценты
  def np_standart ostatok, ps
    np = ostatok * ( ps.to_f / 12.0 )
    np = (np / 100)
  end

  #аннуитетный платеж
  def p_annuitet summa, pers, srok
    summa.to_f * ( pers + (pers / ((( 1 + pers ) ** srok) -1 )))
  end

  # месячная процентная ставка для аннуитета
  def ps percent
    percent.to_f / 12.0 / 100.0
  end

  def prety arr
    1.upto(arr.length-1) do | i |
      arr[i] = '%.2f' % ((arr[i] / 100.0).round(2))
    end
    arr
  end

  # итоговые столбцы
  def get_sum arr, sum_a, sum_b
    arr.each do | sub_arr |
      sum_a = sum_a + sub_arr[2].to_f
      sum_b = sum_b + sub_arr[3].to_f
    end
    sum_a = '%.2f' % (sum_a)
    sum_b = '%.2f' % (sum_b)
    return sum_a, sum_b
  end

end