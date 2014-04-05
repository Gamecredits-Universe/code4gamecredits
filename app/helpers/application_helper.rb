module ApplicationHelper
  def btc_human amount, options = {}
    return nil unless amount
    nobr = options.has_key?(:nobr) ? options[:nobr] : true
    currency = options[:currency] || false
    precision = options[:precision] || 2
    btc = "%.#{precision}f PPC" % to_btc(amount)
    btc = "<span class='convert-from-btc' data-to='#{currency.upcase}'>#{btc}</span>" if currency
    btc = "<nobr>#{btc}</nobr>" if nobr
    btc.html_safe
  end

  def to_btc satoshies
    satoshies.to_d / COIN if satoshies
  end

  def transaction_url(txid)
    "http://bkchain.org/ppc/tx/#{txid}"
  end

  def address_url(address)
    "http://bkchain.org/ppc/address/#{address}"
  end

  def commit_tag(sha1)
    content_tag(:span, truncate(sha1, length: 10, omission: ""), class: "commit-sha")
  end
end
