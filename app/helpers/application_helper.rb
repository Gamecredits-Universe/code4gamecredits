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

  def address_explorers
    [:bkchain, :blockr, :cryptocoin]
  end

  def address_url(address, explorer = address_explorers.first)
    case explorer
    when :blockr then "http://ppc.blockr.io/address/info/#{address}"
    when :bkchain then "http://bkchain.org/ppc/address/#{address}"
    when :cryptocoin then "http://ppc.cryptocoinexplorer.com/address/#{address}"
    else raise "Unknown provider: #{provider.inspect}"
    end
  end

  def commit_tag(sha1)
    content_tag(:span, truncate(sha1, length: 10, omission: ""), class: "commit-sha")
  end
end
