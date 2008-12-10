
# In this class we have only one method defined which
# has a set of attributions.
#
# Each attribution will be used to test when the parser 
# have to generate a symbol for translation.
#
class TestClass

  def some_action
    # Correct Cases
    str = t(:match_1)
    str = t(:match_2  )
    str = t(    :match_3  )
    str = t :match_4
    str = t 'match_5'
    str = t "match_6"
    str = t('match_7')
    str = t("match_8"  ) 
    str = a.push(t("match_9"  ) )
    str = a.push( t("match_10"  ) )
    str = t("match_11")
    str =t("match_12")
    str =t ("match_13")
    str =t (:match_14)
    str =t(:match_15) t(:match_16)
    str =t(:match_17) #t(:match_18)
    # str = t(:match_19)

    str = I18n.t(:match_21)
    str = I18n.t(:match_22  )
    str = t :match_23
    str = t 'match_24'
    str = t "match_25"
    str = I18n.t('match_26')
    str = I18n.t("match_27"  ) 
    str = a.push(I18n.t("match_28"  ) )
    str = a.push( I18n.t("match_29"  ) )
    str = I18n.t("match_30")
    str =I18n.t("match_31")

    # Incorrect Cases
    str = t.(:str_1)
    str = I18n.(:str_2)
    str = I18n.a(:str_3)
    str = I18n.at(:str_4)
    str = test(:str_5)
    str = t e (:str_7)

  end

end
