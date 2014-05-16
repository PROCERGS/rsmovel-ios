//
//  MenuHelper.m
//  RSMovel
//
//  Created by Marcelo Alves Rezende on 04/10/13.
//  Copyright (c) 2013 Marcelo Alves Rezende. All rights reserved.
//

#import "MenuHelper.h"
#import "Secao.h"
#import "Site.h"

@implementation MenuHelper



- (id) init
{
	if (self == [super init])
	{
		menu = [[NSMutableArray alloc] init];
		[self carregaMenuRemoto];
		[self montaMenuJSON];
	}
	return self;
}

- (void) carregaMenuRemoto
{
	// move menu da primeira carga para pasta de documentos
	[self moveMenuFile:@"menu.json"];
	
	// obtem menu local
	NSDictionary *menuLocal = [MenuHelper dictionaryWithContentsOfJSONString:@"menu.json"];
	int versaoMenuLocal = [[menuLocal objectForKey:@"last_update"] intValue];
	
	
	
	// obtem menu remoto
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://m.rs.gov.br/menu.json"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		int versaoMenuRemoto = 0;
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		if (!error)
		{
			versaoMenuRemoto = [[json objectForKey:@"last_update"] intValue];
		}
		
		// se menu remoto é mais novo, atualiza menu local
		if (versaoMenuRemoto > versaoMenuLocal)
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"menu.json"];
			[data writeToFile:filePath atomically:YES];
		}
	}];
	[dataTask resume];
}

- (void) montaMenuJSON
{
	NSDictionary *menuLocal = [MenuHelper dictionaryWithContentsOfJSONString:@"menu.json"];
	NSArray *secoes = [menuLocal objectForKey:@"menu"];
	for (NSDictionary *menuItem in secoes)
	{
		NSString *categoria = [menuItem objectForKey:@"categoria"];
		Secao *secao = [[Secao alloc] initWithTitle:@"Sem categoria" andIcon:@"ico-outros.png"];
		if ([categoria isEqualToString:@"especial"]) {
			secao = [[Secao alloc] initWithTitle:@"Especial" andIcon:@"ico-especial.png"];
		} else if ([categoria isEqualToString:@"servidor_publico"]) {
			secao = [[Secao alloc] initWithTitle:@"Servidor Público" andIcon:@"ico-servidor.png"];
		} else if ([categoria isEqualToString:@"transito"]) {
			secao = [[Secao alloc] initWithTitle:@"Trânsito" andIcon:@"ico-transito.png"];
		} else if ([categoria isEqualToString:@"agricultura"]) {
			secao = [[Secao alloc] initWithTitle:@"Agricultura" andIcon:@"ico-agricultura.png"];
		} else if ([categoria isEqualToString:@"seguranca"]) {
			secao = [[Secao alloc] initWithTitle:@"Segurança" andIcon:@"ico-seguranca.png"];
		} else if ([categoria isEqualToString:@"agenda_do_governador"]) {
			secao = [[Secao alloc] initWithTitle:@"Agenda do Governador" andIcon:@"ico-agenda.png"];
		} else if ([categoria isEqualToString:@"legislativo"]) {
			secao = [[Secao alloc] initWithTitle:@"Legislativo" andIcon:@"ico-legislativo.png"];
		} else if ([categoria isEqualToString:@"saude"]) {
			secao = [[Secao alloc] initWithTitle:@"Saúde" andIcon:@"ico-saude.png"];
		} else if ([categoria isEqualToString:@"agua_e_luz"]) {
			secao = [[Secao alloc] initWithTitle:@"Água e Luz" andIcon:@"ico-agua.png"];
		} else if ([categoria isEqualToString:@"educacao"]) {
			secao = [[Secao alloc] initWithTitle:@"Educação" andIcon:@"ico-educacao.png"];
		} else if ([categoria isEqualToString:@"empresarial"]) {
			secao = [[Secao alloc] initWithTitle:@"Empresarial" andIcon:@"ico-empresarial.png"];
		} else if ([categoria isEqualToString:@"administracao"]) {
			secao = [[Secao alloc] initWithTitle:@"Administração" andIcon:@"ico-administracao.png"];
		} else if ([categoria isEqualToString:@"outros_servicos"]) {
			secao = [[Secao alloc] initWithTitle:@"Outros Serviços" andIcon:@"ico-outros.png"];
		} else if ([categoria isEqualToString:@"cidadania"]) {
			secao = [[Secao alloc] initWithTitle:@"Cidadania" andIcon:@"ico-cidadania.png"];
		} else if ([categoria isEqualToString:@"eventos"]) {
			secao = [[Secao alloc] initWithTitle:@"Eventos" andIcon:@"ico-eventos.png"];
		} else if ([categoria isEqualToString:@"turismo"]) {
			secao = [[Secao alloc] initWithTitle:@"Turismo" andIcon:@"ico-turismo.png"];
		}
		NSArray *itens = [menuItem objectForKey:@"itens"];
		for (NSDictionary *item in itens)
		{
			NSString *titulo = [item objectForKey:@"titulo"];
			NSString *url = [item objectForKey:@"url"];
			[secao addSiteWithTitle:titulo andUrl:url];
		}
		if (itens.count > 0) {
			[menu addObject:secao];
		}
	}
}

- (NSArray*) destaques
{
	NSDictionary *menuLocal = [MenuHelper dictionaryWithContentsOfJSONString:@"menu.json"];
	NSArray *destaquesArray;
	destaquesArray = [menuLocal objectForKey:@"destaques"];
	if (destaquesArray == nil) {
		destaquesArray = [[NSArray alloc] init];
	}
	return destaquesArray;
}



- (void) moveMenuFile:(NSString*)menuFile
{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	path = [documentsDirectory stringByAppendingPathComponent:menuFile];
	if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		[[NSFileManager defaultManager] copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:menuFile] toPath:path error:nil];
	}
}




- (NSArray*) secoes
{
	return menu;
}

- (NSArray*) sitesForSecao:(Secao*)secao
{
	return [secao sites];
}

+ (NSDictionary*) dictionaryWithContentsOfJSONString:(NSString*)fileLocation
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"menu.json"];
	
	NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
