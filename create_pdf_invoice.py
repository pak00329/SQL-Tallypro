def create_invoice(dict_object):

	from reportlab.pdfgen import canvas
	import textwrap, os

	doc_title = dict_object['doc_title']
	company_name = dict_object['company_name']
	company_vat = dict_object['company_vat']
	vat_perc = dict_object['vat_perc']
	company_postal = dict_object['company_postal']
	company_physical = dict_object['company_physical']
	company_tel = dict_object['company_tel']
	company_email = dict_object['company_email']

	customer_name = dict_object['customer_name']
	customer_company_name= dict_object['customer_company_name']
	customer_vat = dict_object['customer_vat']

	doc_date = dict_object['doc_date']
	doc_prefix = dict_object['doc_prefix']
	order_no = dict_object['order_no']
	doc_no = doc_prefix + order_no

	os.chdir('C:\\Users\\Administrator\\downloads\\killer_deals\\') #where to save the documents

	transactions = dict_object['transactions']

	doc_total = 0 #Running total of the invoice

	LEFT_MARGIN = 45 #Left margin of the page, where printing starts
	HEADER_LINE_HEIGHT = 15 #The line height in the header section of the page
	DETAIL_LINE_HEIGHT = 12 #The line height in the detail section of the page

	c = canvas.Canvas(doc_no + '.pdf')

	c.setFont('Helvetica-Bold', 16)
	c.drawString(LEFT_MARGIN, 750, doc_title)

	c.setFont('Helvetica', 11)
	c.drawString(415,750, 'INVOICE NO: ')
	c.drawString(485,750, doc_no)
	c.drawString(450,750 - HEADER_LINE_HEIGHT, 'DATE: ')
	c.drawString(485,750 - HEADER_LINE_HEIGHT, doc_date)
	#Draw lines accross the page
	c.drawString(LEFT_MARGIN,720, '-' * 140) #line below header section
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 8), '-' * 140) #line below company details
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 10), '-' * 140) #line above details section underlining headings
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 45), '-' * 140) #line below details section 

	c.setFont('Helvetica', 10)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 0),'From:')
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 1),company_name)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 2),company_vat)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 3),company_tel)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 4),company_email)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 5),company_postal)
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 6),company_physical)

	bLeft = 380
	c.drawString(bLeft,700 - (DETAIL_LINE_HEIGHT * 0),'To:')
	if customer_company_name== '':
		c.drawString(bLeft,700 - (DETAIL_LINE_HEIGHT * 1),customer_name)
	else:
		c.drawString(bLeft,700 - (DETAIL_LINE_HEIGHT * 1),customer_company_name)
	c.drawString(bLeft,700 - (DETAIL_LINE_HEIGHT * 2),customer_vat)

	#details headings
	c.drawString(LEFT_MARGIN,700 - (DETAIL_LINE_HEIGHT * 9),'QTY')
	c.drawString(LEFT_MARGIN + 50,700 - (DETAIL_LINE_HEIGHT * 9),'DESCRIPTION')
	c.drawRightString(LEFT_MARGIN + 340,700 - (DETAIL_LINE_HEIGHT * 9),'UNIT PRICE (INCL)')
	c.drawRightString(LEFT_MARGIN + 400,700 - (DETAIL_LINE_HEIGHT * 9),'VAT('+ str(vat_perc)+ '%)')
	c.drawRightString(LEFT_MARGIN + 510,700 - (DETAIL_LINE_HEIGHT * 9),'LINE TOTAL (INCL)')

	#details section loop
	column_width = 40
	line_count = 0
	desc_line = 0
	for i in range(0, len(transactions)):
		c.drawString(LEFT_MARGIN,570 - (line_count * DETAIL_LINE_HEIGHT),str(transactions[i]['qty']))
		c.drawRightString(LEFT_MARGIN + 340,570 - (line_count * DETAIL_LINE_HEIGHT),"{:.2f}".format(transactions[i]['unit_price']))
		c.drawRightString(LEFT_MARGIN + 400,570 - (line_count * DETAIL_LINE_HEIGHT),"{:.2f}".format(transactions[i]['qty'] * transactions[i]['unit_price'] /(100 + vat_perc)*vat_perc))
		c.drawRightString(LEFT_MARGIN + 510,570 - (line_count * DETAIL_LINE_HEIGHT),"{:.2f}".format(transactions[i]['qty'] * transactions[i]['unit_price']))
		for desc_line in textwrap.wrap(transactions[i]['desc'], width=column_width):
			c.drawString(LEFT_MARGIN + 50,570 - (line_count * DETAIL_LINE_HEIGHT),desc_line)
			line_count = line_count + 1
		doc_total = doc_total + (transactions[i]['qty'] * transactions[i]['unit_price'])
		

	#Totals section
	doc_subtotal = doc_total / (100 + vat_perc) * 100
	doc_vat_total = doc_total / (100 + vat_perc) * vat_perc
	c.drawRightString(LEFT_MARGIN + 430,700 - (DETAIL_LINE_HEIGHT * 46),'Subtotal: R')
	c.drawRightString(LEFT_MARGIN + 510,700 - (DETAIL_LINE_HEIGHT * 46),"{:.2f}".format(doc_subtotal))
	c.drawRightString(LEFT_MARGIN + 430,700 - (DETAIL_LINE_HEIGHT * 47),'VAT @ ' + str(vat_perc) + '%: R')
	c.drawRightString(LEFT_MARGIN + 510,700 - (DETAIL_LINE_HEIGHT * 47),"{:.2f}".format(doc_vat_total))
	c.drawRightString(LEFT_MARGIN + 430,700 - (DETAIL_LINE_HEIGHT * 48),'Total: R')
	c.drawRightString(LEFT_MARGIN + 510,700 - (DETAIL_LINE_HEIGHT * 48),"{:.2f}".format(doc_total))

	try:
		c.save()
	except:
		print("File is open in another application")
		

	return doc_total

dict_object = {
				'doc_title': 'TAX INVOICE',
				'company_name': 'Killer Deals (Pty) Ltd',
				'company_vat': 'VAT No: 47400221835',
				'vat_perc': 15,
				'company_postal': '',
				'company_physical': '681 Umgeni Rd, Durban, 4001',
				'company_tel': '(031) 312 6785',
				'company_email': 'howzit@killerdeals.co.za',

				'customer_name': '',
				'customer_company_name': '',
				'customer_vat': '',
				'doc_date': '',
				'doc_prefix': 'TAL',
				'order_no': '',
				'transactions': [
								{
								'desc':'', 
								'qty': 1, 
								'unit_price': 0
								},
                                                                
							]
				}			

dict_object['customer_name'] = '''Clinton Govender'''
dict_object['customer_vat'] = ''
dict_object['doc_date'] = '19 Jul 2022'
dict_object['order_no'] =  '110498999'

dict_object['transactions'][0]['desc'] = 'Action Mounts Mini USB Cable for GoPro Hero 4/3+/3 (AM80)'
dict_object['transactions'][0]['qty'] = 1
dict_object['transactions'][0]['unit_price'] = 159.00			

#dict_object['transactions'][1]['desc'] = 'Killer Deals Replacement Silicone Strap for 18mm Garmin Vivoactive 3S/4S - S/M/L'
#dict_object['transactions'][1]['qty'] = 1
#dict_object['transactions'][1]['unit_price'] = 185.00

#dict_object['transactions'][2]['desc'] = 'Killerdeals Garmin Forerunner 35 Replacement Silicone Strap – Pink (S/M/L)'
#dict_object['transactions'][2]['qty'] = 1
#dict_object['transactions'][2]['unit_price'] = 249.00

api_key = '***'

print (create_invoice(dict_object))

